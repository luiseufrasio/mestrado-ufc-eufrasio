package br.ufc.dc.mcc.arida.easyd2rm.servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ufc.dc.mcc.arida.easyd2rm.sqlite.dao.DataPropertyDAO;

@WebServlet(description = "deleta um DataProperty", urlPatterns = { "/DelDataProperty" })
public class DelDataProperty extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DelDataProperty() {
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
			DataPropertyDAO dDAO = new DataPropertyDAO();
			
			dDAO.remove(Integer.parseInt(request.getParameter("id")));
			
			response.getWriter().write("ok");
		} catch (SQLException e) {
			e.printStackTrace();
			response.getWriter().write(e.getMessage());
		}
	}
}