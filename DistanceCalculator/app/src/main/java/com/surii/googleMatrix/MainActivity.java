package com.surii.googleMatrix;

import androidx.appcompat.app.AppCompatActivity;

import android.opengl.Matrix;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.Toast;

import com.surii.googleMatrix.adapter.MatrixAdapter;
import com.surii.googleMatrix.model.MatrixApi;
import com.surii.googleMatrix.model.RequestHandler;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.w3c.dom.Text;

import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {
    private EditText from,to;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        new RequestAsync().execute();
    }
    public class RequestAsync extends AsyncTask<String,String,String> {
        @Override
        protected String doInBackground(String... strings) {
            try {
                // POST Request
                StringBuilder sb=new StringBuilder("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=");
                sb.append("origin");
                sb.append("&destinations=");
                sb.append("destination");
                sb.append("&key=AIzaSyBuUhnC2p8pB65r6S9oHyXQdKY3VvUUqCI");

                return RequestHandler.sendPost(sb.toString());
            }
            catch(Exception e){
                return new String("Exception: " + e.getMessage());
            }
        }

        @Override
        protected void onPostExecute(String s) {
            if(s!=null){
                Toast.makeText(getApplicationContext(), s, Toast.LENGTH_LONG).show();
            }
        }


    }
}