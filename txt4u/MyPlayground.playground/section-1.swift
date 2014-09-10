// Playground - noun: a place where people can play

import UIKit

// created a new array1
var array1 : [String] = []

// add Hi to array1
array1 += ["Hi"]

// create a new array2 based on array1
var array2 = array1;

println(array1)
println(array2)

// .append or += is to way to add new object to arrays in swift
array2.append("Hola")
array2 += ["Hello"]

array1

println(array1)
println(array2)

// create a new array3
var array3 = NSMutableArray()

// add Hi to array3
array3.addObject("Hi")

// add Hello to array4 (which is the same as array3)
var array4 = array3
array4.addObject("Hello")

array3

// swift arrays don't work with pointers , but nsarray and nsdictionary too


