import java.util.StringTokenizer;

public class SentenceReverser {
    public static String reverseFirstAndLast(String text) {
        StringBuilder result = new StringBuilder();
        StringTokenizer tokenizer = new StringTokenizer(text, ".");
        while (tokenizer.hasMoreTokens()) {
            String sentence = tokenizer.nextToken().trim();
            String[] words = sentence.split(" ");
            if (words.length > 1) {
                String temp = words[0];
                words[0] = words[words.length - 1];
                words[words.length - 1] = temp;
            }
            for (int i = 0; i < words.length; i++) {
                result.append(words[i]);
                if (i < words.length - 1) {
                    result.append(" ");
                }
            }
            result.append(".");
            if (tokenizer.hasMoreTokens()) {
                result.append(" ");
            }
        }
        return result.toString();
    }
}
