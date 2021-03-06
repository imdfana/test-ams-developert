﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using Sectores.Domain.Model;

namespace Sectores.Web.Controllers
{
    public class CiudadController : ApiController
    {
        private PruebaContext db = new PruebaContext();

        // GET: api/Ciudad
        public IQueryable<Ciudad> GetCiudades()
        {
            return db.Ciudades;
        }

        // GET: api/Ciudad/5
        [ResponseType(typeof(Ciudad))]
        public IHttpActionResult GetCiudad(int id)
        {
            Ciudad ciudad = db.Ciudades.Find(id);
            if (ciudad == null)
            {
                return NotFound();
            }

            return Ok(ciudad);
        }

        // PUT: api/Ciudad/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutCiudad(int id, Ciudad ciudad)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != ciudad.Id)
            {
                return BadRequest();
            }

            db.Entry(ciudad).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CiudadExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/Ciudad
        [ResponseType(typeof(Ciudad))]
        public IHttpActionResult PostCiudad(Ciudad ciudad)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Ciudades.Add(ciudad);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = ciudad.Id }, ciudad);
        }

        // DELETE: api/Ciudad/5
        [ResponseType(typeof(Ciudad))]
        public IHttpActionResult DeleteCiudad(int id)
        {
            Ciudad ciudad = db.Ciudades.Find(id);
            if (ciudad == null)
            {
                return NotFound();
            }

            db.Ciudades.Remove(ciudad);
            db.SaveChanges();

            return Ok(ciudad);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool CiudadExists(int id)
        {
            return db.Ciudades.Count(e => e.Id == id) > 0;
        }
    }
}