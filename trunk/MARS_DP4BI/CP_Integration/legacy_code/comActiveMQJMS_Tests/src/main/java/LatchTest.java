import java.util.concurrent.CountDownLatch;

public class LatchTest {

    final CountDownLatch latch = new CountDownLatch(1);

    public LatchTest(){

        try {

            latch.await();
        }
        catch(Exception e){


        }



    }

    public static void main(String[] args){



    }
}
