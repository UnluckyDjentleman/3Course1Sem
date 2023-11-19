using System.Collections.Generic;

namespace Aircompany.Planes
{
    public abstract class Plane
    {
        public string Model { get; set; }
        public int MaxSpeed { get; set; }
        public int MaxFlightDistance { get; set; }
        public int MaxLoadCapacity { get; set; }

        public Plane(string model, int maxSpeed, int maxFlightDistance, int maxLoadCapacity)
        {
            Model = model;
            MaxSpeed = maxSpeed;
            MaxFlightDistance = maxFlightDistance;
            MaxLoadCapacity = maxLoadCapacity;
        }
        public override string ToString()
        {
            return $"Plane{{model='{Model}', maxSpeed={MaxSpeed}, maxFlightDistance={MaxFlightDistance}, maxLoadCapacity={MaxLoadCapacity}}}";
        }

        public override bool Equals(object obj)
        {
            var plane = obj as Plane;
            return plane != null &&
                   Model == plane.Model &&
                   MaxSpeed == plane.MaxSpeed &&
                   MaxFlightDistance == plane.MaxFlightDistance &&
                   MaxLoadCapacity == plane.MaxLoadCapacity;
        }

        public override int GetHashCode()
        {
            var hashCode = -1043886837;
            hashCode *= -1521134295;
            hashCode += EqualityComparer<string>.Default.GetHashCode(Model);
            hashCode += MaxSpeed.GetHashCode();
            hashCode += MaxFlightDistance.GetHashCode();
            hashCode += MaxLoadCapacity.GetHashCode();
            return hashCode;
        }        

    }
}
