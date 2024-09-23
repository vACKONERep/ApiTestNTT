package pets;

import com.intuit.karate.junit5.Karate;

public class PetsRunner {
    @Karate.Test
    Karate testPet(){return Karate.run("pets").relativeTo(getClass());}
}
