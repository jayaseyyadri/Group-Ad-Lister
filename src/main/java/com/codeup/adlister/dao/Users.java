package com.codeup.adlister.dao;

import com.codeup.adlister.models.User;

import java.util.List;

public interface Users {
    User findByUsername(String username);
    Long insert(User user);
    boolean isAdmin(long userId);
    List<User> viewUsers();
    List<String> currentUsernames();
    User getDrinkCreator(long drinkId);
}
