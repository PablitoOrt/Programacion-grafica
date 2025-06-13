// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "S_WavingWater"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 2
		_VoronoiScale("VoronoiScale", Range( 3 , 15)) = 10
		_WaterHeight("WaterHeight", Range( 0 , 0.4)) = 0.1
		_WaterSpeed("WaterSpeed", Range( 0 , 5)) = 2
		_Epicenter("Epicenter", Vector) = (0,0,0,0)
		_WaterFrequency("WaterFrequency", Range( 1 , 10)) = 2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
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
			float2 uv_texcoord;
		};

		uniform float3 _Epicenter;
		uniform float _WaterFrequency;
		uniform float _WaterSpeed;
		uniform float _WaterHeight;
		uniform float _VoronoiScale;
		uniform float _EdgeLength;


		float2 voronoihash4( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi4( float2 v, float time, inout float2 id, inout float2 mr, float smoothness )
		{
			float2 n = floor( v );
			float2 f = frac( v );
			float F1 = 8.0;
			float F2 = 8.0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash4( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
					float d = 0.5 * dot( r, r );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			 		}
			 	}
			}
			return F1;
		}


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float temp_output_23_0 = distance( ase_worldPos , _Epicenter );
			float mulTime24 = _Time.y * _WaterSpeed;
			float smoothstepResult32 = smoothstep( 0.0 , 5.0 , temp_output_23_0);
			float temp_output_34_0 = ( sin( ( ( temp_output_23_0 * _WaterFrequency ) - mulTime24 ) ) * ( 1.0 - smoothstepResult32 ) );
			v.vertex.xyz += ( temp_output_34_0 * float3(0,1,0) * _WaterHeight );
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color5 = IsGammaSpace() ? float4(0.1333333,0.8509804,0.8105172,0) : float4(0.01599629,0.6938719,0.6218073,0);
			float time4 = _Time.y;
			float2 coords4 = i.uv_texcoord * _VoronoiScale;
			float2 id4 = 0;
			float2 uv4 = 0;
			float voroi4 = voronoi4( coords4, time4, id4, uv4, 0 );
			float4 voronoiPath7 = ( color5 + voroi4 );
			float4 color13 = IsGammaSpace() ? float4(0.6,1,0.9536936,0) : float4(0.3185468,1,0.8978759,0);
			float3 ase_worldPos = i.worldPos;
			float temp_output_23_0 = distance( ase_worldPos , _Epicenter );
			float mulTime24 = _Time.y * _WaterSpeed;
			float smoothstepResult32 = smoothstep( 0.0 , 5.0 , temp_output_23_0);
			float temp_output_34_0 = ( sin( ( ( temp_output_23_0 * _WaterFrequency ) - mulTime24 ) ) * ( 1.0 - smoothstepResult32 ) );
			float4 lerpResult18 = lerp( voronoiPath7 , color13 , (0.0 + (temp_output_34_0 - 0.0) * (1.0 - 0.0) / (1.0 - 0.0)));
			o.Albedo = lerpResult18.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
879;73;593;596;2061.159;310.0495;2.218216;False;False
Node;AmplifyShaderEditor.CommentaryNode;35;-2260.034,417.9045;Inherit;False;1405.441;525.4847;Comment;12;32;23;22;21;30;24;34;33;28;31;27;25;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldPosInputsNode;22;-2230.838,475.9045;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;21;-2217.838,691.7052;Inherit;False;Property;_Epicenter;Epicenter;8;0;Create;True;0;0;0;False;0;False;0,0,0;0,0,-50;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;30;-1794.462,690.1086;Inherit;False;Property;_WaterSpeed;WaterSpeed;7;0;Create;True;0;0;0;False;0;False;2;2;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-1877.327,478.1058;Inherit;False;Property;_WaterFrequency;WaterFrequency;9;0;Create;True;0;0;0;False;0;False;2;8;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1;-1760.434,11.20192;Inherit;False;904.6032;373.8959;Water texture (Voronoi);6;7;6;5;4;3;2;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DistanceOpNode;23;-2011.938,593.9756;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;24;-1477.942,692.7929;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-1794.915,287.0643;Inherit;False;Property;_VoronoiScale;VoronoiScale;5;0;Create;True;0;0;0;False;0;False;10;3;3;15;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-1566.728,588.2051;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;3;-1707.75,174.3672;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;32;-1784.547,773.1893;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;4;-1479.953,246.5002;Inherit;False;0;0;1;0;1;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.ColorNode;5;-1494.385,70.27106;Inherit;False;Constant;_BaseColor;Base Color;0;0;Create;True;0;0;0;False;0;False;0.1333333,0.8509804,0.8105172,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;31;-1298.9,591.3951;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;6;-1195.124,186.1684;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SinOpNode;28;-1142.539,592.1429;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;33;-1360.321,773.7421;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;7;-1063.525,180.6903;Inherit;False;voronoiPath;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-1016.587,592.7161;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;14;-715.9654,442.3418;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;9;-524.3494,208.018;Inherit;False;7;voronoiPath;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;13;-744.0255,252.5972;Inherit;False;Constant;_Color0;Color 0;2;0;Create;True;0;0;0;False;0;False;0.6,1,0.9536936,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;15;-704.8977,749.8843;Inherit;False;Constant;_DeformationVector;DeformationVector;2;0;Create;True;0;0;0;False;0;False;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;16;-809.0981,911.7847;Inherit;False;Property;_WaterHeight;WaterHeight;6;0;Create;True;0;0;0;False;0;False;0.1;0.1;0;0.4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-387.8637,681.8524;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;18;-371.2062,394.9618;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-134.2258,393.0201;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;S_WavingWater;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;2;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;23;0;22;0
WireConnection;23;1;21;0
WireConnection;24;0;30;0
WireConnection;27;0;23;0
WireConnection;27;1;25;0
WireConnection;32;0;23;0
WireConnection;4;1;3;0
WireConnection;4;2;2;0
WireConnection;31;0;27;0
WireConnection;31;1;24;0
WireConnection;6;0;5;0
WireConnection;6;1;4;0
WireConnection;28;0;31;0
WireConnection;33;0;32;0
WireConnection;7;0;6;0
WireConnection;34;0;28;0
WireConnection;34;1;33;0
WireConnection;14;0;34;0
WireConnection;19;0;34;0
WireConnection;19;1;15;0
WireConnection;19;2;16;0
WireConnection;18;0;9;0
WireConnection;18;1;13;0
WireConnection;18;2;14;0
WireConnection;0;0;18;0
WireConnection;0;11;19;0
ASEEND*/
//CHKSM=27B16DC8D36A24FFAF0D8311AB1FC6BAD7861893