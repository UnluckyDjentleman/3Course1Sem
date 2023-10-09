using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CubeTrig : MonoBehaviour
{
    void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.name == "Floor")
        {
            Debug.Log("Hit the floor");
        }
        else if(collision.gameObject.name == "Wall1")
        {
            Debug.Log("Hit the first wall");
        }
        else if(collision.gameObject.name == "Wall2")
        {
            Debug.Log("Hit the second wall");
        }
    }
}
