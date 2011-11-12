Muffins
========

[![travis](https://secure.travis-ci.org/rclosner/muffins.png)](http://travis-ci.org/rclosner/muffins)

A Nokogiri-based Object to XML/HTML mapping library.

Installation
------------

    gem install muffins

Examples
-----

##XML

    <books>
      <book>
        <asin>1400079985</asin>
        <item_attributes>
          <title>War and Peace (Vintage Classics)</title>
          <author>Leo Tolstoy</author>
          <EAN>9781400079988</EAN>
          <release_date>2008-12-02</release_date>
        </item_attributes>
        <reviews>
          <editorial_review>ZOMG.</editorial_review>
        </reviews>
        <similar_products>
          <similar_product>
            <title>Anna Karenina</title>
            <EAN>9780143035008</EAN>
          </similar_product>
        </similar_products>
      </book>
    </books>

##Map XML

Primary class:

```ruby
    class Book

      include Muffins

      path 'book'

      map :asin, String

      within :item_attributes do |attributes|
        attributes.map :title, String
        attributes.map :author, String, :collection => true
        attributes.map :ean, String, :to => 'EAN'
        attributes.map :release_date, Date
      end

      map :editorial_review, String, :within => :reviews

    end
```

##Usage

```ruby
    Book.parse(xml)
```

returns:

```ruby
    [#<Book:0x233ebe8 @asin='1400079985', @title="War and Peace (Vintage Classics)", @author="Leo Tolstoy", @ean="9781400079988", @release_date=Tue, 02 Dec 2008, @editorial_review='ZOMG.', :similar_products=[#<Product:0x234ebe9 @title='Anna Karenina', @ean='9780143035008'>]>]
```