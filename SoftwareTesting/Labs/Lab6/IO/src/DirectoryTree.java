import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.stream.Stream;
//cd E:\BSTU\3_course\1term\SoftwareTesting\Lab6\IO\out\production\IO
// java DirectoryTree E://BSTU//3_course//1term//SoftwareTesting//Lab6//IO//out//production//IO/directory_tree.txt  - если хотим считать
//java DirectoryTree E:\BSTU\3_course\1term\SystemProgramming - записать
public class DirectoryTree {
    public static void main(String[] args) {
        if (args.length != 1) {
            System.out.println("Надо писать: java DirectoryTree <путь к каталогу или путь к .txt>");
            return;
        }

        String path = args[0];

        if (path.endsWith(".txt")) {
            readAndPrintFromFile(path);
        } else {
            generateAndPrintToFile(path);
        }
    }

    public static void generateAndPrintToFile(String directoryPath) {
        File directory = new File(directoryPath);

        if (!directory.exists() || !directory.isDirectory()) {
            System.out.println("Введи нормальную дерикторию");
            return;
        }

        try {
            FileWriter writer = new FileWriter("directory_tree.txt");
            printDirectoryTree(directory.toPath(), writer, 0);
            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        System.out.println("Структура каталогов сохранена в directory_tree.txt.");
    }

    public static void printDirectoryTree(Path directoryPath, FileWriter writer, int depth) throws IOException {
        try (Stream<Path> entries = Files.list(directoryPath)) {
            entries.forEach(entry -> {
                for (int i = 0; i < depth; i++) {
                    try {
                        writer.write("\t");
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }

                String entryName = entry.getFileName().toString();
                int tabCount = 0;

                while (entryName.charAt(tabCount) == '\t') {
                    tabCount++;
                }

                entryName = entryName.substring(tabCount);

                if (Files.isDirectory(entry)) {
                    try {
                        writer.write("|-----" + entryName + "\n");
                        printDirectoryTree(entry, writer, depth + 1);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                } else {
                    try {
                        writer.write(entryName + "\n");
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            });
        }
    }

    public static void readAndPrintFromFile(String filePath) {
        try {
            BufferedReader reader = new BufferedReader(new FileReader(filePath));
            String line;
            int folderCount = 0;
            int fileCount = 0;
            int totalFileNameLength = 0;

            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    if (line.contains("|-----")) {
                        folderCount++;
                    } else {
                        fileCount++;
                        totalFileNameLength += line.trim().length();
                    }
                }
            }

            reader.close();

            if (folderCount > 0) {
                double averageFilesInFolder = (double) fileCount / folderCount;
                double averageFileNameLength = (double) totalFileNameLength / fileCount;

                System.out.println("Количество папок: " + folderCount);
                System.out.println("Количество файлов: " + fileCount);
                System.out.println("Среднее количество файлов в папке: " + averageFilesInFolder);
                System.out.println("Средняя длина названия файла: " + averageFileNameLength);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
