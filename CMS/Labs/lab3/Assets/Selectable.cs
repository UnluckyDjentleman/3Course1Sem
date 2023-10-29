using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Selectable : MonoBehaviour
{
    public void Select()
    {
        GetComponent<Renderer>().material.color = Color.green;
    }
    public void Disselect()
    {
        GetComponent<Renderer>().material.color = Color.white;
    }
}
