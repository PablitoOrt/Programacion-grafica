using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Camera))]
public class FilmNoiseScript : MonoBehaviour
{
    [SerializeField] private Material FilmNoiseMaterial;
    [SerializeField] private Slider NoiseSlider;

    private void Start()
    {
        if (NoiseSlider != null)
            NoiseSlider.onValueChanged.AddListener(UpdatePower);
    }

    private void UpdatePower(float value)
    {
       
        FilmNoiseMaterial.SetFloat("_NoiseIntensity", value);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (FilmNoiseMaterial != null)
            Graphics.Blit(source, destination, FilmNoiseMaterial);
        else
            Graphics.Blit(source, destination);
    }
}
