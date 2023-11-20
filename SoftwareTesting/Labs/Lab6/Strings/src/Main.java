import java.io.InputStream;
import java.util.List;
import java.util.Scanner;


public class Main {
    public static void main(String[] args) {
        //DeleteWords();
        //ReverseWords();
        //FindUniqueWord();
        //WordReplace();
        CompareStrings();
    }

    public static void DeleteWords() {
        //Из текста удалить все слова заданной длины, начинающиеся на согласную букву.
        String text = "Статический текст для бавгд обработки текста: удаление всех слов, которые начинаются с согласной буквы";
        Scanner scanner = new Scanner(System.in);
        System.out.println("Введите длину слова:");
        int wordLength = scanner.nextInt();
        System.out.println(RemoveWords.removeWords(text, wordLength));
    }

    public static void ReverseWords() {
            //В каждом предложении текста поменять местами первое слово с последним, не изменяя длины предложения.
            String text = "Это наш текст. Здесь много предложений. Каждое предложение заканчивается точкой.";
            System.out.println(SentenceReverser.reverseFirstAndLast(text));
    }



    public static void FindUniqueWord() {
        //Найти такое  слово  в  первом  предложении,  которого  нет  ни  в  одном из остальных предложений
        String text = "Это первое предложение. Это второе предложение. Это третье предложение.";

        String uniqueWord = UniqueWordFinder.findUniqueWord(text);
        System.out.println("Уникальное слово: " + uniqueWord);
    }

    public static void WordReplace() {
        //В некотором предложении текста слова заданной длины заменить указанной подстрокой, длина которой может не совпадать с длиной слова
        String sentence = "Это предложение содержит слова разной длины";
        int wordLength = 5;
        String replacement = "подстрока";

        String result = WordReplacer.replaceWordsOfLength(sentence, wordLength, replacement);
        System.out.println(result);
    }

    public static void CompareStrings() {
        String text = "Это первое предложение, оно является самым длинным из всех представленных.Это самое маленькое.Это третье предложение, которое является средним.";

        List<String> sortedSentences = StringComparator.sortSentencesByWordCount(text);
        for (String sentence : sortedSentences) {
            System.out.println(sentence);
        }
    }
}