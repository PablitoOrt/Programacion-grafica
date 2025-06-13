// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "S_Distance"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 2
		_DisHeight("DisHeight", Range( 0 , 0.5)) = 0.14
		_Epicenter("Epicenter", Vector) = (0,0,0,0)
		_DisFrequency("DisFrequency", Range( 1 , 4)) = 2
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float3 worldPos;
		};

		uniform float3 _Epicenter;
		uniform float _DisFrequency;
		uniform float _DisHeight;
		uniform float _EdgeLength;

		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float temp_output_9_0 = sin( ( ( distance( ase_worldPos , _Epicenter ) + _Time.y ) * _DisFrequency ) );
			float3 temp_output_10_0 = ( temp_output_9_0 * float3(0,4,0) * _DisHeight );
			v.vertex.xyz += temp_output_10_0;
			v.vertex.w = 1;
			v.normal = temp_output_10_0;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color15 = IsGammaSpace() ? float4(0.3378222,0.2042542,0.8490566,0) : float4(0.0933823,0.03444578,0.6903409,0);
			float4 color14 = IsGammaSpace() ? float4(0.04672481,0.6603774,0.379054,0) : float4(0.003647696,0.3936214,0.1186586,0);
			float3 ase_worldPos = i.worldPos;
			float temp_output_9_0 = sin( ( ( distance( ase_worldPos , _Epicenter ) + _Time.y ) * _DisFrequency ) );
			float4 lerpResult16 = lerp( color15 , color14 , (0.0 + (temp_output_9_0 - 0.0) * (1.0 - 0.0) / (1.0 - 0.0)));
			o.Albedo = lerpResult16.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
598;73;1013;645;930.0541;-15.27805;1.3;False;False
Node;AmplifyShaderEditor.Vector3Node;2;-805.2225,367.1877;Inherit;False;Property;_Epicenter;Epicenter;6;0;Create;True;0;0;0;False;0;False;0,0,0;0,0,-10;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldPosInputsNode;1;-818.2224,151.3877;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleTimeNode;6;-599.8227,472.4877;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;4;-559.5225,263.1878;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;5;-388.5227,261.0878;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-523.1227,551.588;Inherit;False;Property;_DisFrequency;DisFrequency;7;0;Create;True;0;0;0;False;0;False;2;1.972024;1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-219.5235,263.6878;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;9;-60.92352,264.9877;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;13;96.47631,79.88746;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;14;-194.6237,8.987511;Inherit;False;Constant;_Color0;Color 0;2;0;Create;True;0;0;0;False;0;False;0.04672481,0.6603774,0.379054,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;15;-194.6237,-168.4125;Inherit;False;Constant;_Color1;Color 1;2;0;Create;True;0;0;0;False;0;False;0.3378222,0.2042542,0.8490566,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;11;-80.62351,364.3879;Inherit;False;Constant;_DeformationVector;DeformationVector;2;0;Create;True;0;0;0;False;0;False;0,4,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;12;-37.82328,533.2877;Inherit;False;Property;_DisHeight;DisHeight;5;0;Create;True;0;0;0;False;0;False;0.14;0.154;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;182.2765,311.2876;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;16;297.2763,-90.21246;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;549.8998,-53.29998;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;S_Distance;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;2;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;1;0
WireConnection;4;1;2;0
WireConnection;5;0;4;0
WireConnection;5;1;6;0
WireConnection;8;0;5;0
WireConnection;8;1;7;0
WireConnection;9;0;8;0
WireConnection;13;0;9;0
WireConnection;10;0;9;0
WireConnection;10;1;11;0
WireConnection;10;2;12;0
WireConnection;16;0;15;0
WireConnection;16;1;14;0
WireConnection;16;2;13;0
WireConnection;0;0;16;0
WireConnection;0;11;10;0
WireConnection;0;12;10;0
ASEEND*/
//CHKSM=A0569F8364968F0038092D7F15F3219A02220AC3