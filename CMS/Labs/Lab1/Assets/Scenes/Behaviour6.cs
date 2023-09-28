using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Behaviour6 : MonoBehaviour
{
    public MeshRenderer render;
    // Start is called before the first frame update
    void Start()
    {
        render=gameObject.GetComponent<MeshRenderer>();
    }

    // Update is called once per frame
    void Update()
    {
        float minX = render.bounds.min.x;
        float maxX=render.bounds.max.x; 
        float minZ= render.bounds.min.z;
        float maxZ=render.bounds.max.z;

        float newX=Random.Range(minX,maxX);
        float newY=gameObject.transform.position.y+5;
        float newZ= Random.Range(minZ, maxZ);

        float ballsX = Random.Range(minX, maxX);
        float ballsY = gameObject.transform.position.y + Random.Range(0,10);
        float ballsZ = Random.Range(minZ, maxZ);

        if (Input.GetKeyDown(KeyCode.Space))
        {
            GameObject cubb = GameObject.CreatePrimitive(PrimitiveType.Cube);
            cubb.transform.position=new Vector3(newX,newY,newZ);
            cubb.AddComponent<Rigidbody>();
        }
        else if (Input.GetMouseButtonDown(0))
        {
            GameObject ball = GameObject.CreatePrimitive(PrimitiveType.Sphere);
            Color col = Random.ColorHSV();
            ball.GetComponent<Renderer>().material.color = col;
            ball.transform.position = new Vector3(ballsX, ballsY, ballsZ);
            ball.AddComponent<Rigidbody>();
        }
    }
}
