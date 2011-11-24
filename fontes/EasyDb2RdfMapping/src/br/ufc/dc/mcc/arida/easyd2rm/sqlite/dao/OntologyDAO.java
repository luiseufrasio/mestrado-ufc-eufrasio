package br.ufc.dc.mcc.arida.easyd2rm.sqlite.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import br.ufc.dc.mcc.arida.easyd2rm.model.Ontology;
import br.ufc.dc.mcc.arida.easyd2rm.sqlite.DBConnection;

public class OntologyDAO {

	public void add(Ontology o) throws SQLException {
		Statement stm = DBConnection.conn.createStatement();
		
		stm.executeUpdate("INSERT INTO Ontology VALUES ('"
				+ o.getPrefix() + "','" + o.getUri() + "')");
		
		stm.close();
	}

	public void remove(String prefix) throws SQLException {
		Statement stm = DBConnection.conn.createStatement();
		
		stm.executeUpdate("DELETE FROM Ontology WHERE prefix=\""
				+ prefix + "\"");
		
		stm.close();
	}

	public void atualizaOntology(Ontology o) throws SQLException {
		Statement stm = DBConnection.conn.createStatement();
		
		stm.executeUpdate("UPDATE Recordes SET prefix=\""
				+ o.getPrefix() + "\"" + "WHERE uri=\"" + o.getUri() + "\"");
		
		stm.close();
	}

	public List<Ontology> findAll() throws SQLException {
		Statement stm = DBConnection.conn.createStatement();
		
		List<Ontology> oList = new ArrayList<Ontology>();
		ResultSet rs;
		rs = stm.executeQuery("SELECT * FROM Ontology "
				+ "ORDER BY prefix ASC ");
		while (rs.next()) {
			oList.add(new Ontology(rs.getString("prefix"), rs.getString("uri")));
		}
		rs.close();
		stm.close();
		
		return oList;
	}

	public List<Ontology> findAllByPrefix(String p) throws SQLException {
		Statement stm = DBConnection.conn.createStatement();
		
		List<Ontology> oList = new ArrayList<Ontology>();
		ResultSet rs;
		rs = stm
				.executeQuery("SELECT * FROM Ontology Where prefix like '" + p
						+ "%' " + " ORDER BY prefix ASC ");
		while (rs.next()) {
			oList.add(new Ontology(rs.getString("prefix"), rs.getString("uri")));
		}
		rs.close();
		stm.close();

		return oList;
	}
}