package br.ufc.dc.mcc.arida.easyd2rm.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import de.fuberlin.wiwiss.d2rq.algebra.Attribute;
import de.fuberlin.wiwiss.d2rq.algebra.RelationName;
import de.fuberlin.wiwiss.d2rq.dbschema.DatabaseSchemaInspector;

/**
 * Servlet implementation class GetColumns
 */
@WebServlet(description = "recupera as colunas de uma tabela", urlPatterns = { "/GetColumns" })
public class GetColumns extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetColumns() {
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
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("sim");
		
		Object o = request.getSession().getAttribute("schema");
		if (o != null) {
			DatabaseSchemaInspector schema = (DatabaseSchemaInspector) o;
			
			String tableName = request.getParameter("tableName");
			System.out.println(tableName);
			
			StringBuffer cols = new StringBuffer("");
			List<RelationName> tables = schema.listTableNames();
			for (RelationName table : tables) {
				if (table.tableName().equals(tableName)) {
					List<Attribute> listCols = schema.listColumns(table);
					for (Attribute att : listCols) {
						if (cols.toString().equals("")) {
							cols.append(att.attributeName());
						} else {
							cols.append("," + att.attributeName());
						}
					}
					
					break;
				}
			}
			
			PrintWriter out = response.getWriter();
			out.write(cols.toString());
		} else {
			response.sendRedirect("pages/configDatabase.jsp?msg=true");
		}
	}

}
