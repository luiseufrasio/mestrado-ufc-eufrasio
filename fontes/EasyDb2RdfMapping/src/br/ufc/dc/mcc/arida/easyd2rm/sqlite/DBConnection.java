package br.ufc.dc.mcc.arida.easyd2rm.sqlite;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import br.ufc.dc.mcc.arida.easyd2rm.model.Ontology;

public class DBConnection {
	private Connection conn;
	private Statement stm;

	public static void createDB(String file) throws SQLException,
			ClassNotFoundException, IOException {
		File f = new File(file);

		if (f.exists()) {
			return;
		}

		f.createNewFile();

		DBConnection db = new DBConnection(file);

		db.stm.executeUpdate("CREATE TABLE Ontology ("
				+ "prefix varchar(20) PRIMARY KEY NOT NULL,"
				+ "uri varchar(100));");

		db.stm.close();
		db.conn.close();
	}

	public DBConnection(String file) throws SQLException,
			ClassNotFoundException {
		Class.forName("org.sqlite.JDBC");
		this.conn = DriverManager.getConnection("jdbc:sqlite:" + file);
		this.stm = this.conn.createStatement();
	}

	public void addOntology(Ontology o) throws SQLException {
		this.stm = this.conn.createStatement();
		this.stm.executeUpdate("INSERT INTO Ontology VALUES ('" + o.getPrefix()
				+ "','" + o.getUri() + "')");
	}

	public void removeOntology(String prefix) {
		try {
			this.stm = this.conn.createStatement();
			this.stm.executeUpdate("DELETE FROM Ontology WHERE prefix=\""
					+ prefix + "\"");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void atualizaOntology(Ontology o) {
		try {
			this.stm = this.conn.createStatement();
			this.stm.executeUpdate("UPDATE Recordes SET prefix=\""
					+ o.getPrefix() + "\"" + "WHERE uri=\"" + o.getUri() + "\"");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<Ontology> getAll() {
		List<Ontology> oList = new ArrayList<Ontology>();
		ResultSet rs;
		try {
			rs = this.stm.executeQuery("SELECT * FROM Ontology "
					+ "ORDER BY prefix ASC ");
			while (rs.next()) {
				oList.add(new Ontology(rs.getString("prefix"), rs
						.getString("uri")));
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return oList;
	}

	public List<Ontology> findAllByPrefix(String p) {
		List<Ontology> oList = new ArrayList<Ontology>();
		ResultSet rs;
		try {
			rs = this.stm.executeQuery("SELECT * FROM Ontology Where prefix like '" + p +"%' "
					+ " ORDER BY prefix ASC ");
			while (rs.next()) {
				oList.add(new Ontology(rs.getString("prefix"), rs
						.getString("uri")));
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return oList;
	}
}
