using UnityEngine;
using UnityEngine.UI;

public class WaterShaderController : MonoBehaviour
{
    [SerializeField] private Material waterMaterial;
    [SerializeField] private Slider heightSlider;
    [SerializeField] private Slider frequencySlider;
    [SerializeField] private Slider speedSlider;
    [SerializeField] private Slider voronoiSlider;

    private void Start()
    {
        if (waterMaterial != null)
        {
            heightSlider?.onValueChanged.AddListener(val => waterMaterial.SetFloat("_WaterHeight", val));
            frequencySlider?.onValueChanged.AddListener(val => waterMaterial.SetFloat("_WaterFrequency", val));
            speedSlider?.onValueChanged.AddListener(val => waterMaterial.SetFloat("_WaterSpeed", val));
            voronoiSlider?.onValueChanged.AddListener(val => waterMaterial.SetFloat("_VoronoiScale", val));
        }
    }
}
