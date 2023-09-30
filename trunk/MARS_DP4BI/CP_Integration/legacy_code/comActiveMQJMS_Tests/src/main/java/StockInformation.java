
public class StockInformation {

    private int id;

    private Float stockPrice;

    private String stockName;

    public Float getStockPrice() {
        return stockPrice;
    }

    public String getStockName() {
        return stockName;
    }

    public void setStockPrice(Float stockPrice) {
        this.stockPrice = stockPrice;
    }

    public void setStockName(String stockName) {
        this.stockName = stockName;
    }

    public int getId() {
        return id;
    }

    public void setId(int ID) {
        this.id = ID;
    }

    public StockInformation(Float stockPrice, String stockName) {
        this.stockPrice = stockPrice;
        this.stockName = stockName;
    }
    public StockInformation(){

    }
}
