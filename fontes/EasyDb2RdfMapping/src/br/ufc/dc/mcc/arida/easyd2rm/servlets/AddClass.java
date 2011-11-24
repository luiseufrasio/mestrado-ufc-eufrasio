package br.ufc.dc.mcc.arida.easyd2rm.servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ufc.dc.mcc.arida.easyd2rm.model.RdfClass;
import br.ufc.dc.mcc.arida.easyd2rm.sqlite.dao.ClassDAO;

@WebServlet(description = "adiciona uma classe rdf na base sqllite", urlPatterns = { "/AddClass" })
public class AddClass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddClass() {
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
			ClassDAO cDAO = new ClassDAO();
			RdfClass c = new RdfClass(request.getParameter("prefix"), request.getParameter("name"));
			
			int id = cDAO.add(c);
			
			response.getWriter().write(id);
		} catch (SQLException e) {
			e.printStackTrace();
			response.getWriter().write("erro");
		}		
	}
}
