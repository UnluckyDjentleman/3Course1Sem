import java.io.FileWriter;
import java.io.IOException;
import java.sql.*;

public class Main {
    public static void main(String[] args) {
        DatabaseQueryExecutor executor = new DatabaseQueryExecutor();

        System.out.println("Вывести информацию обо всех жителях заданного города, разговаривающих на заданном языке:\n");
        executor.printResidentsInfoByCityAndLanguage("Витебск", "Белорусский");
        System.out.println('\n');

        System.out.println("Вывести информацию обо всех городах, в которых проживают жители выбранного типа:\n");
        executor.printCitiesByResidentLanguage("Английский");
        System.out.println('\n');

        System.out.println("Информация о городе с заданным количеством населения и всех типах жителей, в нем проживающих:\n");
        executor.printCityInfoByPopulation(2141000);
        System.out.println('\n');

        System.out.println("Информация о самом древнем типе жителей:\n");
        executor.printOldestResidentsInfo();
    }

}
