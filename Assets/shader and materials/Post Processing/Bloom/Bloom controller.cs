using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Bloomcontroller : MonoBehaviour
{
    [Header("Post Process Material")]
    public Material postProcessMaterial;

    [Header("Bloom Settings")]
    [Range(0, 10)]
    public float bloomIntensity = 1.0f;

    [Header(" UI Control")]
    public Slider bloomSlider;

    private void Start()
    {
       
            bloomSlider.onValueChanged.AddListener(UpdateBloom);
        
    }

    private void UpdateBloom(float value)
    {
        bloomIntensity = value;
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (postProcessMaterial != null)
        {
            postProcessMaterial.SetFloat("_Bloomintensity", bloomIntensity);
            Graphics.Blit(source, destination, postProcessMaterial);
        }
        else
        {
            Graphics.Blit(source, destination);
        }
    }
}
