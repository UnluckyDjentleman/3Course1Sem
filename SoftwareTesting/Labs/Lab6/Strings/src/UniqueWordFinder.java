import java.util.HashMap;
import java.util.Map;

public class UniqueWordFinder {

    public static String findUniqueWord(String text) {
        Map<String, Integer> wordCount = new HashMap<>();
        String[] sentences = text.split("\\.");

        for (String sentence : sentences) {
                String[] words = sentence.trim().split("\\s+");
            for (String word : words) {
                wordCount.put(word, wordCount.getOrDefault(word, 0) + 1);
            }
        }

        String[] firstSentenceWords = sentences[0].trim().split("\\s+");
        for (String word : firstSentenceWords) {
            if (wordCount.get(word) == 1) {
                return word;
            }
        }

        return "Нет уникальных слов";
    }
}