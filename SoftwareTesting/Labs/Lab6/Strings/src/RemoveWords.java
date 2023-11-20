import java.util.Scanner;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RemoveWords {
    public static String removeWords(String text, int length) {
        StringBuilder result = new StringBuilder();
        StringTokenizer tokenizer = new StringTokenizer(text, " ");
        while (tokenizer.hasMoreTokens()) {
            String word = tokenizer.nextToken();
            if (!(word.length() == length && isConsonant(word.charAt(0)))) {
                result.append(word).append(" ");
            }
        }
        return result.toString().trim();
    }

    public static boolean isConsonant(char c) {
        return "бвгджзйклмнпрстфхцчшщ".contains(Character.toString(c).toLowerCase());
    }
}
