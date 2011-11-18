package br.ufc.dc.mcc.arida.easyd2rm.servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ufc.dc.mcc.arida.easyd2rm.model.Ontology;
import br.ufc.dc.mcc.arida.easyd2rm.sqlite.DBConnection;

/**
 * Servlet implementation class AddOntology
 */
@WebServlet(description = "adiciona uma ontologia na base sqllite", urlPatterns = { "/AddOntology" })
public class AddOntology extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddOntology() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			DBConnection db = new DBConnection("db2rdf.db");
			Ontology o = new Ontology(request.getParameter("prefix"), request.getParameter("uri"));
			
			db.addOntology(o);
			
			response.getWriter().write("ok");
		} catch (SQLException e) {
			e.printStackTrace();
			response.getWriter().write(e.getMessage());
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			response.getWriter().write(e.getMessage());
		}		
	}
}
