package br.ufc.dc.mcc.arida.easyd2rm.servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ufc.dc.mcc.arida.easyd2rm.model.DomainLiteral;
import br.ufc.dc.mcc.arida.easyd2rm.model.RdfClass;
import br.ufc.dc.mcc.arida.easyd2rm.sqlite.dao.ClassDAO;
import br.ufc.dc.mcc.arida.easyd2rm.sqlite.dao.DataPropertyDAO;

/**
 * Servlet implementation class GetOntologies
 */
@WebServlet(description = "recupera todas as dataProperties cadastradas", urlPatterns = { "/GetDomains" })
public class GetDomains extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetDomains() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			DataPropertyDAO dDAO = new DataPropertyDAO();
			StringBuffer html = new StringBuffer("");
			int id = Integer.parseInt(request.getParameter("id"));

			List<DomainLiteral> list = dDAO.findDomains(id);

			for (DomainLiteral domainLiteral : list) {
				ClassDAO cDAO = new ClassDAO();
				RdfClass rdfClass = cDAO.findById(id);
				
				html.append("<tr>"
						+ "<td>"
						+ rdfClass.getName()
						+ "</td>"
						+ "<td>"
						+ domainLiteral.getLiteralType()
						+ "</td>"
						+ "<td align=\"center\"><a href=\"#\" onclick=\"javascript: removeRow(this, '"
						+ domainLiteral.getId()
						+ "', 'Domain');\"><img src=\"../images/del.jpg\" border=\"0\"></a></td>"
						+ "</tr>");
			}

			response.getWriter().write(html.toString());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
