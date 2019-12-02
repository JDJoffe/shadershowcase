using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[RequireComponent(typeof(CharacterController))]
public class Player : MonoBehaviour
{
     CharacterController character;
    public Camera headCam;
    public float speed = 6;
    public float gravity = 9.8f;
    public float sensitivityHor = 9.0f;
    public float sensitivityVert = 9.0f;
    public float minimumVert = -45.0f;
    public float maximumVert = 45.0f;
    private float rotationVert = 0;
   public Fog fog;
   bool enableFog = false;
    // Start is called before the first frame update
    void Start()
    {
        character = GetComponent<CharacterController>();
        Cursor.lockState = CursorLockMode.Locked;
        Cursor.visible = false;
        fog = GetComponentInChildren<Fog>();
    }

    // Update is called once per frame
    void Update()
    {         
        movement();
        rotation();   
    }

     public void movement()
    {
        if (Input.GetKey(KeyCode.LeftShift)) { speed = 9f; }
        else { speed = 6; }
        float deltaX = Input.GetAxis("Horizontal") * speed;
        float deltaZ = Input.GetAxis("Vertical") * speed;
        Vector3 movement = new Vector3(deltaX, 0, deltaZ);
        movement = Vector3.ClampMagnitude(movement, speed);
        if(!character.isGrounded)
        {
            movement.y = -gravity;
        }
       
        movement *= Time.deltaTime;
        movement = transform.TransformDirection(movement);
        character.Move(movement);

        if(Input.GetKeyDown(KeyCode.Tab))
        {
            enableFog = !enableFog;
         fog.enabled = enableFog;
        }
        
    }
    public void rotation()
    {
        transform.Rotate(0, Input.GetAxis("Mouse X") * sensitivityHor, 0);
        rotationVert -= Input.GetAxis("Mouse Y") * sensitivityVert;
        rotationVert = Mathf.Clamp(rotationVert, minimumVert, maximumVert);
        headCam.transform.localEulerAngles = new Vector3(rotationVert, headCam.transform.localEulerAngles.y, 0);
    }
}
