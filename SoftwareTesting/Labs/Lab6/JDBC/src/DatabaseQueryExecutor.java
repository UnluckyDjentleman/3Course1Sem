import java.sql.*;

public class DatabaseQueryExecutor {
    public void printResidentsInfoByCityAndLanguage(String cityName, String language) {
        String query = "SELECT Residents.*, Cities.* " +
                "FROM Residents " +
                "JOIN Cities ON Residents.city_id = Cities.city_id " +
                "WHERE Cities.city_name = ? AND Residents.language_spoken = ?";

        try (Connection connection = DatabaseManager.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, cityName);
            preparedStatement.setString(2, language);

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                System.out.println("Resident ID: " + resultSet.getInt("resident_id") +
                        ", Resident Name: " + resultSet.getString("resident_name") +
                        ", Language Spoken: " + resultSet.getString("language_spoken") +
                        ", City ID: " + resultSet.getInt("city_id") +
                        ", City Name: " + resultSet.getString("city_name") +
                        ", Foundation Year: " + resultSet.getInt("foundation_year") +
                        ", Area: " + resultSet.getFloat("area") +
                        ", Population: " + resultSet.getInt("population"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void printCitiesByResidentLanguage(String language) {
        String query = "SELECT DISTINCT Cities.* FROM Cities JOIN Residents ON Cities.city_id = Residents.city_id " +
                "WHERE Residents.language_spoken = ?";

        try (Connection connection = DatabaseManager.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, language);

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                System.out.println("City Name: " + resultSet.getString("city_name") +
                        ", Foundation Year: " + resultSet.getInt("foundation_year") +
                        ", Area: " + resultSet.getFloat("area") +
                        ", Population: " + resultSet.getInt("population"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void printCityInfoByPopulation(int population) {
        String query = "SELECT Cities.*, Residents.resident_name, Residents.language_spoken " +
                "FROM Cities JOIN Residents ON Cities.city_id = Residents.city_id " +
                "WHERE Cities.population = ?";

        try (Connection connection = DatabaseManager.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, population);

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                System.out.println("City Name: " + resultSet.getString("city_name") +
                        ", Foundation Year: " + resultSet.getInt("foundation_year") +
                        ", Area: " + resultSet.getFloat("area") +
                        ", Population: " + resultSet.getInt("population") +
                        ", Resident Name: " + resultSet.getString("resident_name") +
                        ", Language Spoken: " + resultSet.getString("language_spoken"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void printOldestResidentsInfo() {
        String query = "SELECT Residents.*, Cities.city_name, Cities.foundation_year " +
                "FROM Residents JOIN Cities ON Residents.city_id = Cities.city_id " +
                "WHERE Cities.foundation_year = (" +
                "   SELECT TOP 1 MIN(Cities.foundation_year) " +
                "   FROM Residents JOIN Cities ON Residents.city_id = Cities.city_id " +
                "   GROUP BY Residents.language_spoken" +
                ") ORDER BY Residents.resident_id";

        try (Connection connection = DatabaseManager.getConnection();
             Statement statement = connection.createStatement()) {

            ResultSet resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                System.out.println("Resident Name: " + resultSet.getString("resident_name") +
                        ", Language Spoken: " + resultSet.getString("language_spoken") +
                        ", City Name: " + resultSet.getString("city_name") +
                        ", Foundation Year: " + resultSet.getInt("foundation_year"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
