using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Behaviour4 : MonoBehaviour
{
    public float speed = 5;
    private Rigidbody rb;
    public Renderer renderSphere;
    [SerializeField] private Color newColor;
    [SerializeField] private Color[] colors;
    private int ColorId;
    // Start is called before the first frame update
    void Start()
    {
        rb= GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void Update()
    {
        float moveHor = Input.GetAxis("Horizontal");
        float moveVer = Input.GetAxis("Vertical");

        Vector3 movement=new Vector3(moveHor, 0.0f, moveVer);  
        rb.AddForce(movement*speed);
        if (Input.GetKey(KeyCode.Space))
        {
            Vector3 movement1 = new Vector3(moveHor, 5.0f, moveVer);
            rb.AddForce(movement1 * speed);
        }
        else if (Input.GetKey(KeyCode.A))
        {
            newColor = Random.ColorHSV();
            renderSphere.material.color = newColor;
            ColorId++;
            if (ColorId > 5)
            {
                ColorId = 0;
            }
            renderSphere.material.color = colors[ColorId];
        }
    }
}
