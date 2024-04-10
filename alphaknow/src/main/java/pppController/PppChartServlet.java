package pppController;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pppDTO.ProductionPlanPerformanceDTO;

@WebServlet("/ppp.do")
public class PppChartServlet extends HttpServlet {
	
	ProductionPlanPerformanceDAO pppDAO = new ProductionPlanPerformanceDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String select = request.getParameter("select");
		if("all".equals(select)) {
			
			List<ProductionPlanPerformanceDTO> pppList = pppDAO.selectChartList();
			
			for(int i=0; i<pppList.size(); i++) {
				ProductionPlanPerformanceDTO dto = pppList.get(i);
				System.out.println("["+ i +"/toString]"+ dto.toString());
			}
			
			request.setAttribute("list", pppList);
			request.getRequestDispatcher("emp.jsp").forward(request, response);			
		}
		
		
		String insert = request.getParameter("insert");
		if("all".equals(insert)) {
			
			int result = pppDAO.insertProductionData();
			if(result == 1) {
				System.out.println("insert 완료");				
			} else {
				System.out.println("insert 실패");
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
