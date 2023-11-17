using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace lab7
{
    public class Triangle
    {
        public bool CanCreateTriangle(double a, double b, double c)
        {
            if (a + b > c && a + c > b && b + c > a)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        public double TriangleSquare(double a, double b, double c)
        {
            if(CanCreateTriangle(a, b, c))
            {
                return Math.Sqrt((b + c - a) * (a + c - b) * (a + b - c)*(a+b+c) / 16);
            }
            else
            {
                return 0;
            }
        }
        public List<double> AngleValues(double a, double b, double c)
        {
            List<double>angles= new List<double>();
            if (CanCreateTriangle(a, b, c))
            {
                double angleA = Math.Acos((b * b + c * c - a * a) / (2 * b * c))*(180/Math.PI);
                double angleB = Math.Acos((a * a + c * c - b * b) / (2 * a * c)) * (180 / Math.PI);
                double angleC = Math.Acos((a * a + b * b - c * c) / (2 * a * b)) * (180 / Math.PI);
                angles.Add(angleA);
                angles.Add(angleB);
                angles.Add(angleC);
            }
            return angles;
        }
        public String TriangleTypeByAngles(double a, double b, double c)
        {
            if(CanCreateTriangle(a, b, c))
            {
                foreach(double angle in AngleValues(a, b, c))
                {
                    if (angle > 90)
                    {
                        return "Oblique";
                    }
                    else if(angle==90)
                    {
                        return "Right";
                    }
                }
                return "Acute";
            }
            else
            {
                return "";
            }
        }
        public String TriangleTypeBySides(double a, double b, double c)
        {
            if (CanCreateTriangle(a, b, c))
            {
                if (a == b && b == c && a == c)
                {
                    return "Equilaterial";
                }
                else if(a == b || b == c || a == c)
                {
                    return "Isosceles";
                }
                else
                {
                    return "Scalane";
                }
            }
            else
            {
                return "";
            }
        }
    }
}
