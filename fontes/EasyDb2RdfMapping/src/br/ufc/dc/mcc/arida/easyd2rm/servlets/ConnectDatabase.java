package br.ufc.dc.mcc.arida.easyd2rm.servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hp.hpl.jena.rdf.model.ResourceFactory;

import de.fuberlin.wiwiss.d2rq.dbschema.DatabaseSchemaInspector;
import de.fuberlin.wiwiss.d2rq.map.Database;

/**
 * Servlet implementation class ConnectDatabase
 */
@WebServlet(description = "cria a conexão com a base e coloca na requisição", urlPatterns = { "/ConnectDatabase" })
public class ConnectDatabase extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ConnectDatabase() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doGet(req, resp);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		File file = new File("conn.properties");
		Properties properties = new Properties();
		
		String url = request.getParameter("url");
		properties.setProperty("url", url);
		String driver = request.getParameter("driver");
		properties.setProperty("driver", driver);
		String user = request.getParameter("user");
		properties.setProperty("user", user);
		properties.store(new FileOutputStream(file), "");

		Database database = new Database(ResourceFactory.createResource());
		database.setJDBCDSN(url);
		database.setJDBCDriver(driver);
		database.setUsername(user);
		database.setPassword(request.getParameter("password"));
		DatabaseSchemaInspector schema = database.connectedDB()
				.schemaInspector();
		String databaseType = database.connectedDB().dbType();
		
		HttpSession session = request.getSession();
		session.setAttribute("schema", schema);
		session.setAttribute("databaseType", databaseType);
		
		response.sendRedirect(response.encodeRedirectURL("index.jsp"));
	}

}
