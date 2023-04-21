package bean;

public class Book {
    private int ID;
    private String Name;
    private String Author;
    private String Publisher;
    private double Price;
    private String ISBN;

    public Book(int ID, String name, String author, String publisher, double price, String ISBN) {
        this.ID = ID;
        Name = name;
        Author = author;
        Publisher = publisher;
        Price = price;
        this.ISBN = ISBN;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public String getAuthor() {
        return Author;
    }

    public void setAuthor(String author) {
        Author = author;
    }

    public String getPublisher() {
        return Publisher;
    }

    public void setPublisher(String publisher) {
        Publisher = publisher;
    }

    public double getPrice() {
        return Price;
    }

    public void setPrice(double price) {
        Price = price;
    }

    public String getISBN() {
        return ISBN;
    }

    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }
}
