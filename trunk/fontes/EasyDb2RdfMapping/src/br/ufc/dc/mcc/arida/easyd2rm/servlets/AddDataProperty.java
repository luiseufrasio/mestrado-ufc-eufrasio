package br.ufc.dc.mcc.arida.easyd2rm.servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ufc.dc.mcc.arida.easyd2rm.model.DataProperty;
import br.ufc.dc.mcc.arida.easyd2rm.model.DomainLiteral;
import br.ufc.dc.mcc.arida.easyd2rm.model.RdfClass;
import br.ufc.dc.mcc.arida.easyd2rm.sqlite.dao.ClassDAO;
import br.ufc.dc.mcc.arida.easyd2rm.sqlite.dao.DataPropertyDAO;

@WebServlet(description = "adiciona um Data Property na base sqlite", urlPatterns = { "/AddDataProperty" })
public class AddDataProperty extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddDataProperty() {
		super();
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
			DataProperty d = new DataProperty(request.getParameter("prefix"),
					request.getParameter("name"));

			int id = dDAO.add(d);

			response.getWriter().write(id);

			String domainPrefix = request.getParameter("domainPrefix");
			String domainClass = request.getParameter("domainClass");
			String literal = request.getParameter("literal");
			
			ClassDAO classDAO = new ClassDAO();
			RdfClass rdfClass = classDAO.findByPrefixName(domainPrefix, domainClass);

			if (!literal.trim().equals("") && !domainPrefix.trim().equals("")
					&& !domainClass.trim().equals("")) {
				dDAO.addDomain(new DomainLiteral(id, rdfClass.getId(), literal));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			response.getWriter().write("erro");
		}
	}
}
