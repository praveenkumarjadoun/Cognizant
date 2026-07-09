package command;

public class Main {
    public static void main(String[] args) {
        System.out.println("--- Testing Command Pattern ---");

        // Create Receiver
        Light livingRoomLight = new Light();

        // Create Concrete Commands
        Command lightOn = new LightOnCommand(livingRoomLight);
        Command lightOff = new LightOffCommand(livingRoomLight);

        // Create Invoker
        RemoteControl remote = new RemoteControl();

        // 1. Turn Light On
        System.out.println("Setting Command: Turn Light ON");
        remote.setCommand(lightOn);
        remote.pressButton();

        System.out.println();

        // 2. Turn Light Off
        System.out.println("Setting Command: Turn Light OFF");
        remote.setCommand(lightOff);
        remote.pressButton();
    }
}
