# Part 1

```
1. In product.json , find one field that is a number, one that is 
   a list of strings, one that is a nested object and one that is a list of
   objects.

   Number field: `price`
   List of strings: `tags`
   Nested object: `dimensions`
   List of objects: `reviews`

2. Change the address to /products/0 . What status code and body come back?
   Status code: 404
   Body:
        {"message":"Product with id '0' not found"}
```
