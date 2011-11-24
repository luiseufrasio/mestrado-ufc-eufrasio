package br.ufc.dc.mcc.arida.easyd2rm.sqlite.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import br.ufc.dc.mcc.arida.easyd2rm.model.DataProperty;
import br.ufc.dc.mcc.arida.easyd2rm.model.DomainLiteral;
import br.ufc.dc.mcc.arida.easyd2rm.sqlite.DBConnection;

public class DataPropertyDAO {
	public int add(DataProperty d) throws SQLException {
		Statement stm = DBConnection.conn.createStatement();

		stm.executeUpdate("INSERT INTO DataProperty(prefix, name) VALUES ('"
				+ d.getPrefix()
				+ "','"
				+ d.getName() + "')");

		ResultSet rs = stm
				.executeQuery("SELECT id FROM DataProperty WHERE prefix='"
						+ d.getPrefix() + "' AND name='" + d.getName() + "'");
		rs.next();

		int id = rs.getInt("id");

		rs.close();
		stm.close();

		return id;
	}
	
	public int addDomain(DomainLiteral d) throws SQLException {
		Statement stm = DBConnection.conn.createStatement();

		stm.executeUpdate("INSERT INTO DomainLiteral(idDataProperty, class, literalType) VALUES ("
				+ d.getIdDataProperty()
				+ ","
				+ d.getDomain()
				+ ",'"
				+ d.getLiteralType() + "')");

		ResultSet rs = stm
				.executeQuery("SELECT id FROM DomainLiteral WHERE idDataProperty="
						+ d.getIdDataProperty() 
						+ " AND class=" + d.getDomain()
						+ " AND literalType='" + d.getLiteralType() + "'");
		rs.next();

		int id = rs.getInt("id");

		rs.close();
		stm.close();

		return id;
	}

	public void remove(int id) throws SQLException {
		Statement stm = DBConnection.conn.createStatement();

		stm.executeUpdate("DELETE FROM DataProperty WHERE id=\"" + id + "\"");
		stm.close();
	}

	public List<DataProperty> findAll() throws SQLException {
		Statement stm = DBConnection.conn.createStatement();
		List<DataProperty> cList = new ArrayList<DataProperty>();
		ResultSet rs;
		rs = stm.executeQuery("SELECT * FROM DataProperty "
				+ "ORDER BY name ASC ");
		while (rs.next()) {
			cList.add(new DataProperty(rs.getInt("id"), rs.getString("prefix"),
					rs.getString("name")));
		}
		rs.close();
		stm.close();
		return cList;
	}

	public List<DataProperty> findAllByName(String p) throws SQLException {
		Statement stm = DBConnection.conn.createStatement();

		List<DataProperty> cList = new ArrayList<DataProperty>();
		ResultSet rs;
		rs = stm.executeQuery("SELECT * FROM DataProperty Where name like '"
				+ p + "%' " + " ORDER BY name ASC ");
		while (rs.next()) {
			cList.add(new DataProperty(rs.getString("prefix"), rs
					.getString("name")));
		}
		rs.close();
		stm.close();

		return cList;
	}
	
	public List<DomainLiteral> findDomains(int id) throws SQLException {
		Statement stm = DBConnection.conn.createStatement();

		List<DomainLiteral> list = new ArrayList<DomainLiteral>();
		ResultSet rs;
		rs = stm.executeQuery("SELECT * FROM Domain Where idDataProperty=" + id);
		while (rs.next()) {
			list.add(new DomainLiteral(rs.getInt("id"), rs
					.getInt("domain"), rs.getString("literal")));
		}
		rs.close();
		stm.close();

		return list;
	}
}