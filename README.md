# ![market logo](logo) crispy-market
Free Market api tests

- This project has the main intention to do basic tests over MercadoLibre API

- The architecture approach is try to have well defined layers

- Was added few tests on API and search worker to assurance results on API to consume

---

## How to run

- Download project on master branch [master](https://github.com/guillodacosta/crispy-market.git) 
`git clone https://github.com/guillodacosta/crispy-market.git [path]`
- Open "crispy market.xcodeproj" on Finder or Xcode
- Wait to finished download of Swift Package Dependencies and indexing
- Run crispy market target (Ctrl + R)

### How to tests

- Once time you have finished above steps you only need to go to Product and Test or [Ctrl + U]


## Expected flow
 - When you run the application for first time, the application must to request the available country list
    - Once time you have loaded the country list you need to choose a country doing tap
    - Once time have choosed one country you don't need to do anymore
 - On search view you need to select the search bar and start typing your query string
 - Results based on your query appear as a list on screen (each item must to show image, title, price)
 - If you want to see the detail of an item you can do tap on it
 - If you want to search other element you can go back doing tap on Back button of navigation bar


---

## References

* [Mercado Libre API](https://developers.mercadolibre.com.ar/es_ar/categorias-y-publicaciones)
* [Uncle Bob: Clean Architecture](https://www.amazon.com/-/es/Clean-Architecture-Craftsmans-Software-Structure-ebook-dp-B075LRM681/dp/B075LRM681/ref=mt_other?_encoding=UTF8&me=&qid=)

[logo]: https://http2.mlstatic.com/frontend-assets/homes-palpatine/logo_homecom.png
