using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[ExecuteInEditMode]
public class transitionimage : MonoBehaviour
{
   public Renderer rend;
   public float cutoff = 1;
   public float fade = 1;
    // Start is called before the first frame update
    void Awake()
    {
     rend = GetComponent<Renderer>();
     rend.sharedMaterial.shader = Shader.Find("Custom2/BattleTransitions");   
    }

    // Update is called once per frame
    void LateUpdate()
    {
        // if(fade == 1)
        // {
         cutoff = (Mathf.PingPong(Time.time,1f));
        // }
        // if(cutoff > 1)
        // {
        //     fade -= Time.time;
        // }
        // if(fade <= 0)
        // {
             fade = 1;
        // }

        // if(cutoff < 1)
        // {
        // cutoff = 1+Time.time;
        // fade = 1;
        // }
        // if(cutoff >= 1)
        // {
        //     fade =1-Time.time;          
        // }
        // if(fade <= 0)
        // {
        //     cutoff = 0;
        // }
        rend.sharedMaterial.SetFloat("_Cutoff",cutoff);
        rend.sharedMaterial.SetFloat("_Fade",fade);
    }
}
