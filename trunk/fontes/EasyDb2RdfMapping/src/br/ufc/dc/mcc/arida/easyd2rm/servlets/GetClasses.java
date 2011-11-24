package br.ufc.dc.mcc.arida.easyd2rm.servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ufc.dc.mcc.arida.easyd2rm.model.RdfClass;
import br.ufc.dc.mcc.arida.easyd2rm.sqlite.dao.ClassDAO;

/**
 * Servlet implementation class GetOntologies
 */
@WebServlet(description = "recupera todas as classes cadastradas", urlPatterns = { "/GetClasses" })
public class GetClasses extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetClasses() {
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
			ClassDAO cDAO = new ClassDAO();
			
			StringBuffer html = new StringBuffer("");
			
			String n = request.getParameter("query");
			if(n != null) {
				List<RdfClass> list = cDAO.findAllByName(n);
				
				html.append("<ul>\n");
				for (RdfClass rdfClass : list) {
					String name = rdfClass.getName();
					html.append("\t<li id='autocomplete_'" + name + " rel='" + name + "'>" + name + "</li>\n");
				}
				html.append("</ul>");
			} else {
				List<RdfClass> list = cDAO.findAll();
				
				for (RdfClass rdfClass : list) {
					html.append("<tr>" 
							+ "<td>" + rdfClass.getPrefix() + "</td>"
							+ "<td>" + rdfClass.getName() + "</td>"
							+ "<td align=\"center\"><a href=\"#\" onclick=\"javascript: removeRow(this, '" 
							+ rdfClass.getId() + "', 'Class');\"><img src=\"../images/del.jpg\" border=\"0\"></a></td>"
							+ "</tr>");
				}
			}
			
			response.getWriter().write(html.toString());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
