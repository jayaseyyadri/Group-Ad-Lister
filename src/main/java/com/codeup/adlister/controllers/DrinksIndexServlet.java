package com.codeup.adlister.controllers;

import com.codeup.adlister.dao.DaoFactory;
import com.codeup.adlister.models.Drink;
import com.codeup.adlister.util.Password;
import com.codeup.adlister.util.Sorter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "controllers.DrinksIndexServlet", urlPatterns = "/drinks")
public class DrinksIndexServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("drinks", DaoFactory.getDrinksDao().all());
        request.getRequestDispatcher("/WEB-INF/drinks/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchBy = request.getParameter("searchBy");
        String selectValue = request.getParameter("selectValue");
        if (searchBy != null) {
            request.setAttribute("drinks", Sorter.sortDrinksByName(DaoFactory.getDrinksDao().searchDrinks(searchBy)));
        } else if (selectValue.equalsIgnoreCase("byVotes")) {
            request.setAttribute("drinks", Sorter.sortDrinkByVotes(DaoFactory.getDrinksDao().all()));
        }
        else {
            request.setAttribute("drinks", Sorter.sortDrinksByName(DaoFactory.getDrinksDao().getAllByCategory(selectValue)));
        }
        request.getRequestDispatcher("/WEB-INF/drinks/index.jsp").forward(request, response);
    }
}
