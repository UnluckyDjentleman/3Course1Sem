using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Finish : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.name == "Hero")
        {
            GameObject[] go = GameObject.FindGameObjectsWithTag("KillerBee");
            foreach(GameObject go2 in go)
            {
                Destroy(go2);
            }
        }
    }
}
