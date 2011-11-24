package br.ufc.dc.mcc.arida.easyd2rm.sqlite;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnection {
	public static Connection conn;

	static {
		try {
			Class.forName("org.sqlite.JDBC");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		try {
			conn = DriverManager.getConnection("jdbc:sqlite:db2rdf.db");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void createDB() throws SQLException, ClassNotFoundException,
			IOException {
		Statement stm = conn.createStatement();

		stm.executeUpdate("CREATE TABLE IF NOT EXISTS Ontology ("
				+ "prefix varchar(20) PRIMARY KEY NOT NULL,"
				+ "uri varchar(100));");

		stm.executeUpdate("CREATE TABLE IF NOT EXISTS RdfClass ("
				+ "id integer PRIMARY KEY NOT NULL," 
				+ "prefix varchar(20),"
				+ "name varchar(50),"
				+ "FOREIGN KEY(prefix) REFERENCES Ontology(prefix) ON DELETE CASCADE,"
				+ "UNIQUE(prefix,name));");

		stm.executeUpdate("CREATE TABLE IF NOT EXISTS DataProperty ("
				+ "id integer PRIMARY KEY NOT NULL," 
				+ "prefix varchar(20),"
				+ "name varchar(50),"
				+ "FOREIGN KEY(prefix) REFERENCES Ontology(prefix) ON DELETE CASCADE,"
				+ "UNIQUE(prefix,name));");

		stm.executeUpdate("CREATE TABLE IF NOT EXISTS ObjectProperty ("
				+ "id integer PRIMARY KEY NOT NULL," 
				+ "prefix varchar(20),"
				+ "name varchar(50),"
				+ "FOREIGN KEY(prefix) REFERENCES Ontology(prefix) ON DELETE CASCADE,"
				+ "UNIQUE(prefix,name));");

		stm.executeUpdate("CREATE TABLE IF NOT EXISTS DomainLiteral ("
				+ "id integer PRIMARY KEY NOT NULL," 
				+ "idDataProperty integer,"
				+ "class integer," 
				+ "literalType varchar(20),"
				+ "FOREIGN KEY(class) REFERENCES RdfClass(id) ON DELETE CASCADE,"
				+ "FOREIGN KEY(idDataProperty) REFERENCES DataProperty(id) ON DELETE CASCADE);");

		stm.executeUpdate("CREATE TABLE IF NOT EXISTS DomainRange ("
				+ "id integer PRIMARY KEY NOT NULL," 
				+ "idObjectProperty integer,"
				+ "classDomain integer," 
				+ "classRange integer,"
				+ "FOREIGN KEY(classDomain) REFERENCES RdfClass(id) ON DELETE CASCADE,"
				+ "FOREIGN KEY(classRange) REFERENCES RdfClass(id) ON DELETE CASCADE,"
				+ "FOREIGN KEY(idObjectProperty) REFERENCES ObjectProperty(id) ON DELETE CASCADE);");

		stm.close();
	}
}