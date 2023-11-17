using lab7;
using System;

class Program
{
    public static void Main(string[] args)
    {
        var triangle = new Triangle();
        Console.WriteLine("Square of triangle: "+triangle.TriangleSquare(5, 4, 3));
        Console.WriteLine("Triangle type by sides is "+triangle.TriangleTypeBySides(5,4,3));
        Console.WriteLine("Triangle angles:");
        Console.WriteLine("-----------------------------------------------");
        foreach(float item in triangle.AngleValues(5, 4, 3))
        {
            Console.WriteLine(item);
        }
        Console.WriteLine("-----------------------------------------------");
        Console.WriteLine("Triangle type by angles is "+triangle.TriangleTypeByAngles(5,4,3));
    }
}
