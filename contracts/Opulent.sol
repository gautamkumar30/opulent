pragma solidity ^0.8.0;

contract Opulent {
    struct Product {
        uint id;
        string brand;
        string description;
        string imageUrl;
        bool isVerified;
    }

    mapping(uint => Product) public products;
    uint public productCount;

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only the admin can call this function");
        _;				
    }

    constructor() {
        admin = msg.sender;
    }

    address admin;

    function registerProduct(string memory _brand, string memory _description, string memory _imageUrl) public onlyAdmin {
        productCount++;
        products[productCount] = Product(productCount, _brand, _description, _imageUrl, false);
    }

    function verifyProduct(uint _productId) public onlyAdmin {
        require(_productId > 0 && _productId <= productCount, "Invalid product ID");
        products[_productId].isVerified = true;
    }

    function getProduct(uint _productId) public view returns (uint, string memory, string memory, string memory, bool) {
        require(_productId > 0 && _productId <= productCount, "Invalid product ID");
        Product memory product = products[_productId];
        return (product.id, product.brand, product.description, product.imageUrl, product.isVerified);
    }
}