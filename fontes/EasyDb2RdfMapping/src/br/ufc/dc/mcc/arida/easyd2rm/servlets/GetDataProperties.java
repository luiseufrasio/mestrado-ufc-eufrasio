package br.ufc.dc.mcc.arida.easyd2rm.servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ufc.dc.mcc.arida.easyd2rm.model.DataProperty;
import br.ufc.dc.mcc.arida.easyd2rm.sqlite.dao.DataPropertyDAO;

/**
 * Servlet implementation class GetOntologies
 */
@WebServlet(description = "recupera todas as dataProperties cadastradas", urlPatterns = { "/GetDataProperties" })
public class GetDataProperties extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetDataProperties() {
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
			DataPropertyDAO dDAO = new DataPropertyDAO();
			
			StringBuffer html = new StringBuffer("");
			
			String n = request.getParameter("query");
			if(n != null) {
				List<DataProperty> list = dDAO.findAllByName(n);
				
				html.append("<ul>\n");
				for (DataProperty dataProperty : list) {
					String name = dataProperty.getName();
					html.append("\t<li id='autocomplete_'" + name + " rel='" + name + "'>" + name + "</li>\n");
				}
				html.append("</ul>");
			} else {
				List<DataProperty> list = dDAO.findAll();
				
				for (DataProperty dataProperty : list) {
					html.append("<tr>" 
							+ "<td>" + dataProperty.getPrefix() + "</td>"
							+ "<td>" + dataProperty.getName() + "</td>"
							+ "<td align='center'><input type=\"radio\" name=\"rDomains\" onclick=\"showDomains('" + dataProperty.getId() + "', this)\"></td>"
							+ "<td align=\"center\"><a href=\"#\" onclick=\"javascript: removeRow(this, '" 
							+ dataProperty.getId() + "', 'DataProperty');\"><img src=\"../images/del.jpg\" border=\"0\"></a></td>"
							+ "</tr>");
				}
			}
			
			response.getWriter().write(html.toString());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
