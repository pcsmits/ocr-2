import java.util.ArrayList;

/**
 * Created by pcsmits on 12/7/14.
 */
public class Ngram {
    DataExtractor d;
    ArrayList<String> letterPaths;

    public Ngram(){
        d = new DataExtractor();
        letterPaths = new ArrayList<String>();
    }


    public ArrayList<String> getWord(String word){
        findNgram(word, "");
        return letterPaths;

    }

    /*recursive function to find best Ngram*/
    private void findNgram(String chunk1, String chunk2){
        // check if n-1 exists
        if (d.has(chunk1)) {
            //base case
            //match chunk 1 set to chunk 2 set using congruency model
            //Congruency with preceding char and succeding char
            Congruency c = new Congruency();
            letterPaths.addAll(c.getBestMatch(chunk1, Character.toString(chunk2.charAt(0))));
            //start over
            findNgram(chunk2, "");
        } else {
            //Given a word cut it into n-1 and 1
            String tmp = Character.toString(chunk1.charAt(chunk1.length() - 1));
            chunk2 = tmp + chunk2;
            chunk1 = chunk1.substring(0,chunk1.length()-2);
            findNgram(chunk1, chunk2);
        }
    }
}
