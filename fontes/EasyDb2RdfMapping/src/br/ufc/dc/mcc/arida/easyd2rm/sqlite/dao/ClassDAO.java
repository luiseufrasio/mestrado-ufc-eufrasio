package br.ufc.dc.mcc.arida.easyd2rm.sqlite.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import br.ufc.dc.mcc.arida.easyd2rm.model.RdfClass;
import br.ufc.dc.mcc.arida.easyd2rm.sqlite.DBConnection;

public class ClassDAO {
	public int add(RdfClass c) throws SQLException {
		Statement stm = DBConnection.conn.createStatement();
		
		stm
				.executeUpdate("INSERT INTO RdfClass(prefix, name) VALUES ('"
						+ c.getPrefix() + "','" + c.getName() + "')");

		ResultSet rs = stm
				.executeQuery("SELECT id FROM RdfClass WHERE prefix='"
						+ c.getPrefix() + "' AND name='" + c.getName() + "'");
		rs.next();
		
		int id = rs.getInt("id");
		
		rs.close();
		stm.close();
		
		return id;
	}

	public void remove(int id) throws SQLException {
		Statement stm = DBConnection.conn.createStatement();
		
		stm.executeUpdate("DELETE FROM RdfClass WHERE id=\"" + id
				+ "\"");
		stm.close();
	}

	public List<RdfClass> findAll() throws SQLException {
		Statement stm = DBConnection.conn.createStatement();
		List<RdfClass> cList = new ArrayList<RdfClass>();
		ResultSet rs;
		rs = stm.executeQuery("SELECT * FROM RdfClass "
				+ "ORDER BY name ASC ");
		while (rs.next()) {
			cList.add(new RdfClass(rs.getInt("id"), rs.getString("prefix"), rs.getString("name")));
		}
		rs.close();
		stm.close();
		return cList;
	}

	public List<RdfClass> findAllByName(String p) throws SQLException {
		Statement stm = DBConnection.conn.createStatement();
		
		List<RdfClass> cList = new ArrayList<RdfClass>();
		ResultSet rs;
		rs = stm
				.executeQuery("SELECT * FROM RdfClass Where name like '" + p
						+ "%' " + " ORDER BY name ASC ");
		while (rs.next()) {
			cList.add(new RdfClass(rs.getString("prefix"), rs.getString("name")));
		}
		rs.close();
		stm.close();
		
		return cList;
	}
	
	public RdfClass findById(int id) throws SQLException {
		Statement stm = DBConnection.conn.createStatement();
		
		ResultSet rs;
		rs = stm
				.executeQuery("SELECT * FROM RdfClass Where id =" + id);
		rs.next();
		RdfClass rdfClass = new RdfClass(rs.getString("prefix"), rs.getString("name"));
		
		rs.close();
		stm.close();
		
		return rdfClass;
	}
	
	public RdfClass findByPrefixName(String p, String n) throws SQLException {
		Statement stm = DBConnection.conn.createStatement();
		
		ResultSet rs;
		rs = stm
				.executeQuery("SELECT * FROM RdfClass Where prefix = '" + p
						+ "' AND name = '" + n + "'");
		rs.next();
		RdfClass rdfClass = new RdfClass(rs.getInt("id"), rs.getString("prefix"), rs.getString("name"));
		
		rs.close();
		stm.close();
		
		return rdfClass;
	}
}