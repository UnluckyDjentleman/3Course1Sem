import java.util.*;

public class StringComparator {

    public static List<String> sortSentencesByWordCount(String text) {
        String[] sentences = text.split("\\.");
        List<String> sentenceList = new ArrayList<>(Arrays.asList(sentences));

        Collections.sort(sentenceList, Comparator.comparingInt(StringComparator::countWords));

        return sentenceList;
    }

    public static int countWords(String sentence) {
        String[] words = sentence.trim().split("\\s+");
        return words.length;
    }
}
