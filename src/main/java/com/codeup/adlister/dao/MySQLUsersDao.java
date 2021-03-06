package com.codeup.adlister.dao;

import com.codeup.adlister.models.Drink;
import com.codeup.adlister.models.User;
import com.mysql.cj.jdbc.Driver;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class MySQLUsersDao implements Users {
    private Connection connection= null;

    public MySQLUsersDao(Config config) {
        try {
            DriverManager.registerDriver(new Driver());
            connection = DriverManager.getConnection(
                    config.getUrl(),
                    config.getUser(),
                    config.getPassword()
            );
        } catch (SQLException e) {
            throw new RuntimeException("Error connecting to the database!", e);
        }
    }

    /**--------------------- VIEW USERS ------------------------------*/
    @Override
    public List<User> viewUsers() {
        PreparedStatement stmt = null;
        String query = "Select username, id, is_admin from comrade_snifter_db.users";
        List<User> usersList = new ArrayList<>();
        try {
            stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            stmt.executeQuery();
            ResultSet rs = stmt.getResultSet();
            while (rs.next()) {
                User user = new User(
                        rs.getLong("id"),
                        rs.getString("username")
                );
                if(rs.getInt("is_admin") < 1) {
                    usersList.add(user);
                }
            }
            return usersList;
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving user List.", e);
        }
    }


    /**--------------------- VIEW OTHER ADMINS ------------------------------*/
    @Override
    public List<User> viewAdmins(String currentUsername) {
        String query = "Select username, id, is_admin from comrade_snifter_db.users";
        List<User> adminList = new ArrayList<>();
        try {
            PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            stmt.executeQuery();
            ResultSet rs = stmt.getResultSet();
            while (rs.next()) {
                User user = new User(
                        rs.getLong("id"),
                        rs.getString("username")
                );
                if(rs.getInt("is_admin") > 0 && !rs.getString("username").equals(currentUsername)) {
                    adminList.add(user);
                }
            }
            return adminList;
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving admin List.", e);
        }
    }

/**----------------------FIND BY USERNAME-----------------------------*/
    @Override
    public User findByUsername(String username) {
        String query = "SELECT * FROM comrade_snifter_db.users WHERE username = ? LIMIT 1";
        try {
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, username);
            return extractUser(stmt.executeQuery());
        } catch (SQLException e) {
            throw new RuntimeException("Error finding a user by username", e);
        }
    }

/**----------------------CREATE A NEW USER----------------------------*/
    @Override
    public Long insert(User user) {
        String query = "INSERT INTO comrade_snifter_db.users(username, email, password, image) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getImage());
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            rs.next();
            return rs.getLong(1);
        } catch (SQLException e) {
            throw new RuntimeException("Error creating new user", e);
        }
    }

    /**-----------------CHECK IF USER IS AN ADMIN-----------------------*/
    @Override
    public boolean isAdmin(long userId) {
        String query = "SELECT is_admin FROM comrade_snifter_db.users where id = ?";
        int thisId = 0;
        try {
            PreparedStatement stm = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            stm.setLong(1, userId);
            stm.executeQuery();
            ResultSet rs = stm.getResultSet();
            rs.next();
            thisId = (int) rs.getLong("is_admin");

        } catch (SQLException e) {
            throw new RuntimeException("Error validating user", e);
        }
        return thisId == 1;
    }


    /**--------------------DELETE USER--------------------------------*/
    @Override
    public void deleteUser(long userId){
        String query = "delete from users where id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            statement.setLong(1, userId);
            statement.execute();

        } catch (SQLException e){
            throw new RuntimeException("Error deleting user", e);
        }
    }

    /**-----------------------CURRENT USER--------------------------- */
    @Override
    public Set<String> currentUsernames(){
        Set<String> allCurrentUserNames = new HashSet<>();
        String query = "SELECT username FROM comrade_snifter_db.users";

        try{

            PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            statement.executeQuery();
            ResultSet rs = statement.getResultSet();
            while(rs.next()){
                allCurrentUserNames.add(
                  rs.getString("username")
                );
            }
            return allCurrentUserNames;

        } catch (SQLException e){
            throw new RuntimeException("Error retrieving current user list", e);
        }

    }

    /**------------------FIND CREATOR OF DRINK-----------------------*/
    @Override
    public User getDrinkCreator(long drinkId){
        Drink thisDrink = DaoFactory.getDrinksDao().getDrink(drinkId);
        String query = "SELECT * from comrade_snifter_db.users where id  = ?";

        try{

            PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            statement.setLong(1, thisDrink.getUserId());
            statement.executeQuery();
            ResultSet rs = statement.getResultSet();
            return extractUserPublicInfo(rs);

        } catch (SQLException e){
            throw new RuntimeException("Error finding creator for this drink", e);
        }

    }

    /**------------------UPDATE USER PROFILE------------------------*/
    @Override
    public void updateUserInformation(User user)  {
        //update info based on current user's id
        PreparedStatement stmt = null;
        String sqlQuery ="UPDATE comrade_snifter_db.users SET username = ?, email = ?, password = ?, image = ? WHERE id = ?";
        try{
            stmt = connection.prepareStatement(sqlQuery, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1,user.getUsername());
            stmt.setString( 2,user.getEmail());
            stmt.setString(  3,user.getPassword());
            stmt.setString(  4,user.getImage());
            stmt.setLong(5,user.getId());
            stmt.executeUpdate();
        }catch(SQLException e){
            throw new RuntimeException("Error updating profile.", e);
        }
    }

    /**------------------UPDATE USER PASSWORD------------------------*/
    @Override
    public void updateUserPassword(String userName, String newPassword){
        String query = "Update comrade_snifter_db.users set password = ? where username = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, newPassword);
            statement.setString(2, userName);
            statement.executeUpdate();

        } catch (SQLException e ){
            throw new RuntimeException("Error changing your password", e);
        }
    }


    /**--------------------HELPER FUNCTION --------------------------*/
    private User extractUser(ResultSet rs) throws SQLException {
        if (!rs.next()) {
            return null;
        }
        return new User(
                rs.getLong("id"),
                rs.getString("username"),
                rs.getString("email"),
                rs.getString("password"),
                rs.getString("image")
        );
    }

    /**------------------VIEW CREATOR OF A DRINK----------------------*/
    private User extractUserPublicInfo(ResultSet rs) throws SQLException {
        if (!rs.next()) {
            return null;
        }
        return new User(
                rs.getString("username"),
                rs.getString("image")
        );
    }

}
