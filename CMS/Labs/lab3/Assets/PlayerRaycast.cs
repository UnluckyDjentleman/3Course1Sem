using System.Collections;
using System.Collections.Generic;
using UnityEditor.UI;
using UnityEngine;

public class PlayerRaycast : MonoBehaviour
{
    public Transform Pointer;
    public Selectable currentSelectable;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        Ray ray=Camera.main.ScreenPointToRay(Input.mousePosition);
        Debug.DrawRay(transform.position, transform.forward * 10f, Color.red);

        RaycastHit hit;
        if (Physics.Raycast(ray,out hit))
        {
            Pointer.position = hit.point;
            Selectable selectable = hit.collider.gameObject.GetComponent<Selectable>();
            if (selectable)
            {
                if (currentSelectable && currentSelectable != selectable)
                {
                    currentSelectable.gameObject.transform.localScale = Vector3.one * 0.5f;
                    currentSelectable.Disselect();
                }
                currentSelectable = selectable;
                currentSelectable.gameObject.transform.localScale = Vector3.one * 1.2f;
                selectable.Select();
            }
            else
            {
                if (currentSelectable)
                {
                    currentSelectable.gameObject.transform.localScale = Vector3.one*0.5f;
                    currentSelectable.Disselect();
                    currentSelectable = null;
                }
            }
        }
        else
        {
            if (currentSelectable)
            {
                currentSelectable.gameObject.transform.localScale = Vector3.one * 0.5f;
                currentSelectable.Disselect();
                currentSelectable = null;
            }
        }
    }
}
