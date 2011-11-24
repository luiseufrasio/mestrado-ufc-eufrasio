package br.ufc.dc.mcc.arida.easyd2rm.servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ufc.dc.mcc.arida.easyd2rm.model.Ontology;
import br.ufc.dc.mcc.arida.easyd2rm.sqlite.dao.OntologyDAO;

/**
 * Servlet implementation class GetOntologies
 */
@WebServlet(description = "recupera todas as ontologias cadastradas", urlPatterns = { "/GetOntologies" })
public class GetOntologies extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetOntologies() {
        super();
        // TODO Auto-generated constructor stub
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
			OntologyDAO oDAO = new OntologyDAO();
			
			StringBuffer html = new StringBuffer("");
			
			String p = request.getParameter("query");
			if(p != null) {
				List<Ontology> list = oDAO.findAllByPrefix(p);
				
				html.append("<ul>\n");
				for (Ontology ontology : list) {
					String prefix = ontology.getPrefix();
					html.append("\t<li id='autocomplete_'" + prefix + " rel='" + prefix + "'>" + prefix + "</li>\n");
				}
				html.append("</ul>");
			} else {
				List<Ontology> list = oDAO.findAll();
				
				for (Ontology ontology : list) {
					html.append("<tr>" 
							+ "<td>" + ontology.getPrefix() + "</td>"
							+ "<td>" + ontology.getUri() + "</td>"
							+ "<td align=\"center\"><a href=\"#\" onclick=\"javascript: removeRow(this, '" 
							+ ontology.getPrefix() + "', 'Ontology');\"><img src=\"../images/del.jpg\" border=\"0\"></a></td>"
							+ "</tr>");
				}
			}
			
			response.getWriter().write(html.toString());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
