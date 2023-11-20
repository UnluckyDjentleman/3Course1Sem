public class WordReplacer {
    public static String replaceWordsOfLength(String sentence, int wordLength, String replacement) {
        String[] words = sentence.split("\\s+");
        for (int i = 0; i < words.length; ++i) {
            if (words[i].length() == wordLength) {
                words[i] = replacement;
            }
        }
        String resultString = String.join(" ", words);
        return resultString;
    }
}
